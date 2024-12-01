using ZonaRTX.data;
using ZonaRTX.Models;

public interface IProductosRepository : IBaseRepository<ProductosModel>
{
    Task<bool> CategoriaExisteAsync(int idCategoria);
}
