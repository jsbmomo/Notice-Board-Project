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
            // 초기 페이지 설정 및 세팅
            if (!Page.IsPostBack)
            {
                Comment_Panel.Visible = false; // 댓글 작성 창을 처음엔 숨김                
            }

            board_id = Request.QueryString["board_id"].ToString(); // get 방식
            BoardIndex.Text = board_id; // 보드 주소 저장 
            int commentCount = CommentGridView.Rows.Count; // 전체 댓글의 개수 count
            CommentCount_lbl.Text = commentCount.ToString();

            // 게시물에 표현될 제목, 내용, 작성이
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
                Response.Redirect("~/WritePost.aspx?&board_id=" + board_id + "&previousPage=Contents");
            }
            else
            {
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script> alert('게시판을 수정할 권한이 없습니다.') </script>");
            }
            
        }

        // 이전글 버튼을 눌렀을 경우 Previous 문자열을 준다
        protected void Previous_Btn_Click(object sender, EventArgs e)
        {
            SearchContents("Previous");
        }

        // 다음글 버튼을 눌렀을 경우 Next 문자열을 준다
        protected void Next_Btn_Click(object sender, EventArgs e)
        {
            SearchContents("Next");
        }

        // 이전 또는 다음글의 내용을 SQL과 연동하여 불러온다.
        void SearchContents(string otherContents)
        {
            string sql = "";
            if(otherContents == "Previous")
            {
                // 이전 글을 가져오는 쿼리 = 현재 게시물 index 값보다 작은 값 중
                // 내림차순을 통해 가장 큰 인덱스 값을 가져오는 방식
                sql = "SELECT TOP 1 number FROM Board WHERE number < @Number ORDER BY number DESC;";
            } 
            else if(otherContents == "Next")
            {
                // 다음 글을 가져오는 쿼리 = 현재 게시물의 index 값보다 큰 값 중
                // 가장 작은 인덱스 값을 가져오는 방식
                sql = "SELECT TOP 1 number FROM Board WHERE number > @Number ORDER BY number;";
            }

            SqlConnection con = new SqlConnection(conSql);

            try
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Number", board_id); // 현재 게시판의 Index

                // MSSQL DB에서는 number가 int로 저장되어 있음
                int nextBoardID = 0;
                try
                {
                    object obj = cmd.ExecuteScalar();

                    nextBoardID = obj == null ? 0 : (int)obj;
                } 
                catch(NullReferenceException ex)
                {
                    nextBoardID = 0;
                }
                
                
                con.Close();

                if (nextBoardID <= 0) // int의 기본값은 0
                {
                    if(otherContents == "Previous") // 이전 또는 다음 게시판이 없다면 알림창 발생
                        ClientScript.RegisterStartupScript(typeof(Page), "alert",
                            "<script> alert('이전 게시물이 없습니다.'); </script>");
                    else
                        ClientScript.RegisterStartupScript(typeof(Page), "alert",
                            "<script> alert('다음 게시물이 없습니다.'); </script>");
                }
                else
                {
                    // 이전 또는 다음 게시판이 있다면 이동 
                    Response.Redirect("~/Contact.aspx?board_id=" + nextBoardID);
                }
            }
            catch(Exception ex)
            {
                Response.Write(ex);
            }
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

                CommentGridView.DataBind();
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

        // 댓글 삭제 및 수정 기능 작성
        // 댓글을 작성한 사용자의 권한이 필요(hidden 방식으로 작성자가 아닌자는 button 숨기기)
        // DeleteComment 버튼의 OnClientClick 옵션을 통해, 확인 또는 취소가 가능한 알림창이 뜨고
        // 확인을 누를 경우에만 OnClick 이벤트가 실행된다.
        protected void DeleteComment_Click(object sender, EventArgs e)
        {
            // GridView의 TemplateField 안에 있는 Text를 가져오기 위해 사용
            // 아래의 방법은 GridView에서 특정 행의 텍스트를 가져오는 방법으로 
            // Rows[0]은 GridView의 가장 첫번째 값을 가져온다.
            //-- string commentIndex = ((TextBox)CommentList.FindControl("HiddenIndex")).Text;

            // 위의 방법을 응용하여 댓글의 인덱스를 찾는 방법을 사용하고 있다.
            // 버튼의 리스너를 가져오고, 버튼의 GridView 내의 열(Row) 위치를 가져온다.
            // 이후, 행(Cells)의 위치를 가져오고, FindControl로 Label를 선택하여 텍스트를 가져온다.
            Button deleteBtn = (Button)sender;
            GridViewRow gridrow = (GridViewRow)deleteBtn.NamingContainer;
            string commentIndex = ((TextBox)gridrow.Cells[0].FindControl("HiddenIndex")).Text;

            SqlConnection con = new SqlConnection(conSql);
            string sql = "DELETE FROM Comment WHERE num=@Number";
            SqlCommand cmd = new SqlCommand(sql, con);

            cmd.Parameters.AddWithValue("@Number", commentIndex);

            try
            {
                con.Open();
                cmd.ExecuteNonQuery();

                CommentGridView.DataBind(); // GridView 갱신(connection이 닫히기 전에 사용해야 한다.

                con.Close();
            }
            catch(Exception ex)
            {
                Response.Write(ex);
            }
        }


        //댓글의 내용을 수정하는 버튼(댓글 수정을 위한 텍스트 박스 및 버튼 보이기)
        protected void ReplaceComment_Click(object sender, EventArgs e)
        {
            Button btnLocation = (Button)sender;
            GridViewRow gridRow = (GridViewRow)btnLocation.NamingContainer;

            // 버튼을 클릭했을때, 댓글을 수정하는 TextBox가 보이는 경우(초기에는 안보임)
            if (gridRow.Cells[0].FindControl("UpdateComment").Visible) // Label, button이 안보임
            {
                gridRow.Cells[0].FindControl("WrittenComment").Visible = true;
                gridRow.Cells[0].FindControl("UpdateComment").Visible = false;
                gridRow.Cells[0].FindControl("CancelUpdate").Visible = false;
                gridRow.Cells[0].FindControl("UpdateCommentBtn").Visible = false;
            } 
            else // 초기 상태일 경우(TextBox, Button이 안보임)
            {
                //***************** 현재 대입하려는 값이 null이라는 오류 발생
                //((TextBox)gridRow.Cells[0].FindControl("UpdateComment")).Text = ((Label)gridRow.Cells[0].FindControl("comment")).Text;

                gridRow.Cells[0].FindControl("WrittenComment").Visible = false;
                gridRow.Cells[0].FindControl("CancelUpdate").Visible = true;
                gridRow.Cells[0].FindControl("UpdateCommentBtn").Visible = true;
                gridRow.Cells[0].FindControl("UpdateComment").Visible = true;
            }
        }

        // 수정한 댓글의 내용을 DB에 저장하는 버튼 
        protected void UpdateCommentBtn_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(conSql);
            string sql = "UPDATE Comment SET comment=@Comment WHERE num = @Number_Comment";
            SqlCommand cmd = new SqlCommand(sql, con);
        }

        protected void CancelUpdate_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow gridRow = (GridViewRow)btn.NamingContainer;

            gridRow.Cells[0].FindControl("WrittenComment").Visible = true;
            gridRow.Cells[0].FindControl("UpdateComment").Visible = false;
            gridRow.Cells[0].FindControl("CancelUpdate").Visible = false;
            gridRow.Cells[0].FindControl("UpdateCommentBtn").Visible = false;
        }
    }
}