﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Login.QuanTri
{
    public partial class Xem_PhieuXuat : Form
    {
        private string MaQT;
        SqlConnection cnn = new SqlConnection(@"Data Source=.\SQLEXPRESS;Initial Catalog = CUA_HANG_HOA;Integrated Security = True");
        public Xem_PhieuXuat()
        {
            InitializeComponent();
        }

        public Xem_PhieuXuat(string MaQT)
        {
            this.MaQT = MaQT;
            InitializeComponent();
        }

        private void Xem_PhieuNhap_Load(object sender, EventArgs e)
        {
            try
            {
                cnn.Open();
                string sql = $"select * from PHIEU_XUAT WHERE QT_PHUTRACH = {MaQT}";
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
            string mapx = textBox1.Text.Trim();
            if (mapx == "")
            {
                MessageBox.Show("Không được để khoảng trống", "Warning");
            }
            else
            {
                try
                {
                    cnn.Open();
                    string sql = $"select * from CT_PHIEU_XUAT WHERE Ma_PN = {mapx}";
                    SqlCommand com = new SqlCommand(sql, cnn);
                    com.CommandType = CommandType.Text;
                    SqlDataAdapter da = new SqlDataAdapter(com);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    dataGridView2.DataSource = dt;
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message, "Warning");
                }
                finally
                {
                    cnn.Close();
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
