using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace NoticeProject
{
    public partial class Contact : Page
    {
        private string board_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            board_id = Request.QueryString["board_id"].ToString();

            string conSql = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(conSql);
            string sql = "SELECT header, input_info FROM Board WHERE number=@Number";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@Number", board_id);

            try
            {
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                string board_header = "";
                string board_contents = "";
                while (reader.Read())
                {
                    board_header = reader["header"].ToString();
                    board_contents = reader["input_info"].ToString();
                }
                headerlbl.Text = board_header;
                Literal.Text = board_contents;

                reader.Close();
                con.Close();
            }
            catch(Exception ex)
            {
                Response.Write(ex);
            }
            
        }

        protected void BackButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/NoticePage.aspx");
        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/WritePost.aspx?board_id=" + board_id + "&nowPage=Contents");
        }

        protected void Previous_Btn_Click(object sender, EventArgs e)
        {

            SearchContents();
        }

        protected void Next_Btn_Click(object sender, EventArgs e)
        {

            SearchContents();
        }

        void SearchContents()
        {
            
        }

    }
}