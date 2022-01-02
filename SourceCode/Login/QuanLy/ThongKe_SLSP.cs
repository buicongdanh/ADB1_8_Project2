using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Login.QuanLy
{
    public partial class ThongKe_SLSP : Form
    {
        private string MaQL;
        SqlConnection cnn = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog = CUA_HANG_HOA;Integrated Security = True");
        public ThongKe_SLSP()
        {
            InitializeComponent();
        }

        public ThongKe_SLSP(string MaQL)
        {
            this.MaQL = MaQL;
            InitializeComponent();
        }

        private void Xem_PhieuNhap_Load(object sender, EventArgs e)
        {
            try
            {
                cnn.Open();
                string sql = $"EXCE thong_ke_so_luong @MaQL = {MaQL}";
                SqlCommand com = new SqlCommand(sql, cnn);
                com.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Caution");
            }
            finally
            {
                cnn.Close();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
           
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
