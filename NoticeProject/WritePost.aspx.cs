using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace NoticeProject
{
    public partial class WritePost : System.Web.UI.Page
    {
        private string updateContents_userID { get; set; } // Post로 게시물을 수정하고자 하는 사용자 ID를 받음
        private string updateContents_index { get; set; } // Post로 수정될 게시물의 인덱스를 받음 

        private string sqlCon = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            Written.Text = Session["LoginUsers"].ToString();

            // 만약 게시물을 새로 생성하는 것이 아니라 수정하는 것이라면(받은 값이 있다면),
            // Post로 받아온 내용(ID, Index)을 sql문에 작성 후, 해당 내용을 화면(TextBox)에 표시
            //HttpContext context = HttpContext.Current;
            //updateContents_index = context.Items["index"].ToString();
            //updateContents_userID = context.Items["Id"].ToString();

            string board_id = Request.QueryString["board_id"].ToString();

            if (string.IsNullOrEmpty(board_id))
            {
                SqlConnection con = new SqlConnection(sqlCon);
                string sql = "SELECT header, input_info FROM Board WHERE number=@Index and user_id=@User_ID";
                //input_info=@NewContents header=@NewHeader 
                // @Index @User_ID"

                try
                {
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@Index", board_id);
                    cmd.Parameters.AddWithValue("@User_ID", Written.Text);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                } 
                catch(Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }

        }

        protected void CancelBtn_Click(object sender, EventArgs e)
        {
            //Response.Redirect(Request.QueryString["~/NoticePage.aspx"]);
            Response.Redirect("~/NoticePage.aspx");
        }


        // 만약 새로 게시물을 생성할 경우.
        protected void CreateBoardBtn_Click(object sender, EventArgs e)
        {
            string sqlConnect = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sqlConnect);
            string sql = "INSERT INTO Board(user_id, header, input_info) VALUES(@UserID, @Header, @Input_Info)";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@UserID", Written.Text);
            cmd.Parameters.AddWithValue("@Header", WriteHeader.Text);
            cmd.Parameters.AddWithValue("@Input_Info", WriteContents.Text);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }


        // 만약 기존의 내용을 수정할 경우 
        protected void UpdateContentsBtn_Click(object sender, EventArgs e)
        {
            string sqlCon = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(sqlCon);
            string sql = "UPDATE Board SET input_info=@NewContents, header=@NewHeader WHERE number=@Index and user_id=@User_ID";

            try
            {
                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@NewContents", WriteContents.Text);
                cmd.Parameters.AddWithValue("@NewHeader", WriteHeader.Text);
                cmd.Parameters.AddWithValue("@Index", updateContents_index);
                cmd.Parameters.AddWithValue("@User_ID", updateContents_userID);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script> alert('정상적으로 변경되었습니다.'); </script>");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}
    
