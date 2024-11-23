namespace ZonaRTX.Models
{
    public class PedidosModel
    {
        public int id_pedido { get; set; }
        public int id_usuario { get; set; }
        public DateTime fecha_pedido { get; set; }
        public string estado { get; set; } // Valores posibles: pendiente, enviado, completado, cancelado
        public float total { get; set; }
    }
}
