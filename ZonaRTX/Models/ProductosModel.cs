namespace ZonaRTX.Models
{
    public class ProductosModel
    {
        public int id_producto { get; set; }
        public string nombre_producto { get; set; }
        public string descripcion { get; set; }
        public decimal precio { get; set; }
        public int id_categoria { get; set; }
        public DateTime? fecha_agregado { get; set; }
        
    }

}
