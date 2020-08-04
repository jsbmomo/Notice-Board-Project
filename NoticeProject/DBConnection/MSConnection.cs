using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;

namespace NoticeProject.DBConnection
{
    public class MSConnection
    {
        private SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString);
        private IDbCommand _Cmd = null;
        //private SqlDataAdapter adapter = null;
        //private DataTable dataTable = null;
        //private SqlCommand cmd = new SqlCommand();
        //private IDbCommand = null;


        // DB에서 찾은 모든 값을 DataTable로 반환
        public DataTable GetDataTable(string query, params string[] param)
        {
            SqlDataAdapter adapter = new SqlDataAdapter();
            DataTable dataTable = new DataTable();

            _Cmd = new SqlCommand();
            _Cmd.Connection = con;
            _Cmd.Connection.Open();

            _Cmd.CommandType = CommandType.Text;
            _Cmd.CommandText = query;

            ((SqlCommand)_Cmd).Parameters.Clear();
            if(param != null) {
                for(int i = 0; i < param.Length; i++) 
                {
                    string str = (param[i] == null ? string.Empty : param[i]);
                    ((SqlCommand)_Cmd).Parameters.AddWithValue("@" + (i + 1), str);
                }
            }

            adapter.SelectCommand = (SqlCommand)_Cmd;
            adapter.Fill(dataTable);

            return dataTable;
        }


        // query문을 받아서 실행하고 성공여부 반환
        public bool ExcuteQuery(string query, List<object> param)
        {
            _Cmd = new SqlCommand();
            _Cmd.Connection = con;
            _Cmd.Connection.Open();

            _Cmd.CommandType = CommandType.Text;
            _Cmd.CommandText = query;

            ((SqlCommand)_Cmd).Parameters.Clear();
            if (param != null) 
            {
                for (int i = 0; i < param.Count; i++) 
                {
                    object obj = (param[i] == null ? string.Empty : param[i]);
                    ((SqlCommand)_Cmd).Parameters.AddWithValue("@" + (i + 1), obj.ToString());
                }
            }

            try
            {
                _Cmd.ExecuteNonQuery();
                return true;
            }
            catch(Exception ex)
            {
                Console.Write(ex);
                return false;
            }
        }


        // query문을 받아서 실행하고 결과값을 반환(받은 쪽에서 형변환 필요)
        public int ScalarExecute(string query)
        {
            _Cmd = new SqlCommand();
            _Cmd.Connection = con;
            _Cmd.Connection.Open();

            _Cmd.CommandType = CommandType.Text;
            _Cmd.CommandText = query;

            try
            {
                return (_Cmd.ExecuteScalar() == null) ? 0 : (int)_Cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                Console.Write(ex);
                return -1;
            }
        }


        // DataTable을 클라이언트에게 JSON으로 보내기 위해 변환하는 과정
        public string GetJson(DataTable table) 
        {
            //var toJson = new JavaScriptSerializer();
            //toJson.RegisterConverters(new JavaScriptConverter[] { new DataTableConverter() });
            //return toJson.Serialize(table);

            string jsonString = string.Empty;
            jsonString = JsonConvert.SerializeObject(table);
            return jsonString;
        }

        public void CloseDB()
        {
            con.Close();
        }

    }
}