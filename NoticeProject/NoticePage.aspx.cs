using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace NoticeProject
{
    public partial class LoginPage : System.Web.UI.Page
    {
        private string sqlCon = ConfigurationManager.ConnectionStrings["DBConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Login_UserID_lbl.Text = Session["LoginUsers"].ToString();
        }

        protected void movepage_Click(object sender, EventArgs e)
        {

        }

        protected void NoticeGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
        }

        protected void NewNotice_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/WritePost.aspx?board_id=&previousPage=main");
        }

        // 게시물 삭제 버튼을 클릭했을 경우.
        protected void deleteBtn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender; // 
            GridViewRow row = (GridViewRow)btn.NamingContainer; // 
            string written_id = row.Cells[2].Text; // 버튼이 위치한 열에서 ID(string)를 가져옴

            if(written_id == Session["LoginUsers"].ToString())
            {
                string index = row.Cells[0].Text;
                int board_index = int.Parse(index);

                try
                {
                    //Response.Write($"{written_id} == {Session["LoginUsers"].ToString()} ID가 일치함을 확인!");
                    SqlConnection con = new SqlConnection(sqlCon);
                    string sql = "DELETE FROM dbo.Board WHERE user_id=@UserID AND number=@Number";
                    SqlCommand cmd = new SqlCommand(sql, con);

                    cmd.Parameters.AddWithValue("@UserID", written_id);
                    cmd.Parameters.AddWithValue("@Number", board_index);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    ClientScript.RegisterStartupScript(typeof(Page), "alert",
                        "<script>alert('성공적으로 게시물을 삭제했습니다.'); </script>");

                    NoticeGrid.DataBind(); // grid view를 새로 고침  
                }
                catch(Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
            else
            {
                //권한이 없습니다. (알림창)
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script>alert('해당 게시물을 삭제할 권한이 없습니다.') </script>");
            }
            
        }


        // 게시물 수정 버튼을 클릭했을 경우.
        protected void updateBtn_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridViewRow row = (GridViewRow)btn.NamingContainer;
            string written_id = row.Cells[2].Text; // grid view에 작성된 ID를 가져옴 

            if (written_id == Session["LoginUsers"].ToString())
            {
                string index = row.Cells[0].Text;
                int board_index = int.Parse(index);

                //// 수정할 게시물에 대한 데이터를 보냄(ID, INDEX) <=  Post 방식(하지만 에러발생)
                //HttpContext context = HttpContext.Current;
                //context.Items.Add("index", board_index);
                //context.Items.Add("Id", written_id);

                //Server.Transfer("~/WritePost.aspx", true);

                Response.Redirect("~/WritePost.aspx?board_id=" + board_index + "&previousPage=Board");
            }
            else
            {
                //권한이 없습니다. (알림창)
                ClientScript.RegisterStartupScript(typeof(Page), "alert",
                    "<script>alert('해당 게시물을 수정할 권한이 없습니다.') </script>");
            }
        }

        protected void NoticeGrid_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }




        /* 게시판 정렬 기능 추가시 디자인 페이지에서 "정렬 기능 사용"에 체크해 줌으로
         * 간단하게 사용가능하다. 하지만 해당 기능을 직접 생성하고 싶다면 아래의 소스 코드를 
         * 사용한다.
        // GridView의 정렬을 수행(GridView의 OnSorting에 선언한 메소드)
        protected void NoticeGrid_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable dataTable = (DataTable)ViewState["dirState"];
            if(dataTable.Rows.Count > 0)
            {
                if(Convert.ToString(ViewState["sortdr"]) == "Asc")
                {
                    dataTable.DefaultView.Sort = e.SortExpression + " Desc";
                    ViewState["sortdr"] = "Desc";
                }
                else
                {
                    dataTable.DefaultView.Sort = e.SortExpression + "Asc";
                    ViewState["sortdr"] = "Asc";
                }
                NoticeGrid.DataSource = dataTable;
                NoticeGrid.DataBind();
            }
        }

        // Grid 데이터를 가져오는 메소드 
        public void GridViewSortDESC()
        {
            SqlConnection con = new SqlConnection(sqlCon);
            string sql = "SELECT number, user_id, header, input_date FROM dbo.Board";
            SqlCommand cmd = new SqlCommand(sql, con);

            SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sqlDataAdapter.Fill(dt);

            NoticeGrid.DataSource = dt;
            NoticeGrid.DataBind();
            ViewState["dirState"] = dt;
            ViewState["Sortdr"] = "Asc";
        }*/

    }
}