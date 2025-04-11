using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Serialization;

namespace lab03
{
    public partial class Form3 : Form
    {
        AccountsData accountsData;

        public Form3(AccountsData accountsData)
        {
            InitializeComponent();
            this.accountsData = accountsData;
        }
        private void Form3_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = accountsData.Accounts;
            dataGridView1.Refresh();
        }
        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                using (FileStream stream = new FileStream("newaccounts.xml", FileMode.Create))
                {
                    XmlSerializer serializer = new XmlSerializer(typeof(AccountsData));
                    serializer.Serialize(stream, accountsData);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }
        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
