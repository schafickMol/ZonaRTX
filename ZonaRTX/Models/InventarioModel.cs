namespace ZonaRTX.Models
{
    public class InventarioModel
    {
        public int id_pedido {  get; set; }
        public int id_usuario { get; set; }
        public DateTime fecha_pedido { get; set; }
        public string estado {  get; set; } //Tipos de estado que usaremos: pendiente, enviado, completado, cancelado

    }
}
