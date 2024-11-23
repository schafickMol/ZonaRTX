namespace ZonaRTX.Models
{
    public class DetallesPedidosModel
    {
        public int id_detalle {  get; set; }
        public int id_pedido { get; set; }
        public int id_producto { get; set; }
        public int cantidad { get; set; }
        public float precio_unitario { get; set; }

    }
}
