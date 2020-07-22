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
        private string board_id = ""; // 게시판의 고유 넘버
        private string conSql = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            Comment_Panel.Visible = false;
            board_id = Request.QueryString["board_id"].ToString();
            BoardIndex.Text = board_id;

            SqlConnection con = new SqlConnection(conSql);
            string sql = "SELECT header, user_id, input_info FROM Board WHERE number=@Number";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@Number", board_id);

            try
            {
                con.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                string board_header = "";
                string board_contents = "";
                string board_writter = ""; // 게시판 작성자의 아이디를 가져옴 
                while (reader.Read())
                {
                    board_writter = reader["user_id"].ToString();
                    board_header = reader["header"].ToString();
                    board_contents = reader["input_info"].ToString();
                }

                // 게시물 저장 시, mssql이 개행문자 역시 하나의 문자로만 저장을 한다.
                // 때문에 줄바꿈 시 사용되는 해당 문자(\r\n)를 <br />로 교체하여 줄바꿈을
                // 해주었다.
                string text = board_contents.Replace("\r\n", "<br />");

                Written.Text = board_writter;
                headerlbl.Text = board_header;
                Literal.Text = text;

                reader.Close();
                con.Close();
            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }
            
        }

        // 메인화면으로 돌아가는 버튼
        protected void BackButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/NoticePage.aspx");
        }

        // 게시물 내용 수정 시, 게시물 내용 수정 페이지로 이동하는 버튼 
        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            // DB에서 작성자의 ID를 가져오고, 세션을 통해
            // 현재 사용자의 ID를 가져와서 비교
            if (Written.Text == Session["LoginUsers"].ToString()) 
            {
                Response.Redirect("~/WritePost.aspx?&board_id=" + board_id + "&nowPage=Contents");
            }
            else
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script> alert('게시판을 수정할 권한이 없습니다.') </script>");
            }
            
        }

        // 이전글 버튼을 눌렀을 경우 특정 값을 준다
        protected void Previous_Btn_Click(object sender, EventArgs e)
        {
            SearchContents("Previous");
        }

        // 다음글 버튼을 눌렀을 경우 특정 값을 준다
        protected void Next_Btn_Click(object sender, EventArgs e)
        {
            SearchContents("Next");
        }

        // 이전 또는 다음글의 내용을 SQL과 연동하여 불러온다.
        void SearchContents(string otherContents)
        {
            string others = "";
            if(otherContents == "Previous")
            {

            } 
            else if(otherContents == "Next")
            {

            }

            SqlConnection con = new SqlConnection(conSql);
            string sql = "";
            SqlCommand cmd = new SqlCommand(sql, con);

        }

        // 댓글 작성 후, 등록할때.
        protected void CommentInput_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(conSql);
            string sql = "INSERT INTO Comment(board_number, comment, user_id) VALUES(@BoardNumber, @Comment, @Written)";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@BoardNumber", board_id);
            cmd.Parameters.AddWithValue("@Comment", Comment.Text);
            cmd.Parameters.AddWithValue("@Written", Session["LoginUsers"].ToString());

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();

                CommentList.DataBind();
                Comment.Text = string.Empty; // 기존 TextBox의 내용을 모두 지움 

                con.Close();
            }
            catch(Exception ex)
            {
                Response.Write(ex);
            }
        }

        protected void CommentHidden_Click(object sender, EventArgs e)
        {
            // 댓글을 작성하는 TextBox를 "댓글 작성" 버튼을 누를때마다
            // 보이게 하게나 또는 숨김(기본적으로 숨김상태)
            if (Comment_Panel.Visible) 
            {
                Comment_Panel.Visible = false;
            }
            else
            {
                Comment_Panel.Visible = true;
            }
        }
    }
}