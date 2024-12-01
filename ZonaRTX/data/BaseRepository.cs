using Dapper;
using Microsoft.Data.SqlClient;
using ZonaRTX.data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

public class BaseRepository<T> : IBaseRepository<T>
{
    private readonly ISqlDataAccess _db;

    // Mapeo de las tablas a sus nombres de columnas de identificación
    private static readonly Dictionary<string, string> TableMap = new Dictionary<string, string>
    {
        { "CategoriasModel", "Categorias" },
        { "InventarioModel", "Inventario" },
        { "DetallesPedidosModel", "DetallePedidos" },
        { "PedidosModel", "Pedidos" },
        { "ProductosModel", "Productos" },
        { "ProductosProveedoresModel", "ProductoProveedores" },
        { "ProveedoresModel", "Proveedores" },
        { "UsuariosModel", "Usuarios" }
    };

    // Mapeo de las columnas de identificación para cada modelo
    private static readonly Dictionary<string, string> IdColumnMap = new Dictionary<string, string>
    {
        { "CategoriasModel", "id_categoria" },
        { "InventarioModel", "id_inventario" },
        { "DetallesPedidosModel", "id_detalle" },
        { "PedidosModel", "id_pedido" },
        { "ProductosModel", "id_producto" },
        { "ProductosProveedoresModel", "id_producto_proveedor" },
        { "ProveedoresModel", "id_proveedor" },
        { "UsuariosModel", "id_usuario" }
    };

    public BaseRepository(ISqlDataAccess db)
    {
        _db = db;
    }

    // Obtener el nombre de la tabla correspondiente
    private string GetTableName()
    {
        var modelName = typeof(T).Name;
        return TableMap.ContainsKey(modelName) ? TableMap[modelName] : $"{modelName}s";
    }

    // Obtener un registro por su ID
    public async Task<T> GetByIdAsync(int id)
    {
        var tableName = GetTableName();
        var idColumnName = IdColumnMap.ContainsKey(typeof(T).Name) ? IdColumnMap[typeof(T).Name] : "id"; // Usa "id" por defecto

        var query = $"SELECT * FROM {tableName} WHERE {idColumnName} = @Id";

        using (var connection = _db.GetConnection())
        {
            return await connection.QueryFirstOrDefaultAsync<T>(query, new { Id = id });
        }
    }

    // Obtener todos los registros
    public async Task<IEnumerable<T>> GetAllAsync()
    {
        var tableName = GetTableName();
        var query = $"SELECT * FROM {tableName}";
        using (var connection = _db.GetConnection())
        {
            return await connection.QueryAsync<T>(query);
        }
    }

    // Insertar un nuevo registro
    public async Task<int> InsertAsync(T entity)
    {
        try
        {
            var tableName = GetTableName();
            var properties = typeof(T).GetProperties()
                .Where(p => !p.Name.Equals("Id", StringComparison.OrdinalIgnoreCase)); // Excluir 'Id'

            var columns = string.Join(", ", properties.Select(p => p.Name));
            var values = string.Join(", ", properties.Select(p => $"@{p.Name}"));

            var query = $"INSERT INTO {tableName} ({columns}) VALUES ({values})";

            using (var connection = _db.GetConnection())
            {
                return await connection.ExecuteAsync(query, entity);
            }
        }
        catch (SqlException ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
            throw;
        }
    }

    // Actualizar un registro existente
    public async Task<int> UpdateAsync(T entity)
    {
        var tableName = GetTableName();
        var idColumnName = IdColumnMap.ContainsKey(typeof(T).Name) ? IdColumnMap[typeof(T).Name] : "id"; // Usa "id" por defecto

        var properties = typeof(T).GetProperties()
            .Where(p => !p.Name.Equals(idColumnName, StringComparison.OrdinalIgnoreCase)); // Excluir columna de id

        var setClause = string.Join(", ", properties.Select(p => $"{p.Name} = @{p.Name}"));
        var query = $"UPDATE {tableName} SET {setClause} WHERE {idColumnName} = @{idColumnName}";

        using (var connection = _db.GetConnection())
        {
            return await connection.ExecuteAsync(query, entity);
        }
    }

    // Eliminar un registro por su ID
    public async Task<int> DeleteAsync(int id)
    {
        var tableName = GetTableName();
        var idColumnName = IdColumnMap.ContainsKey(typeof(T).Name) ? IdColumnMap[typeof(T).Name] : "id"; // Usa "id" por defecto

        var query = $"DELETE FROM {tableName} WHERE {idColumnName} = @Id";

        using (var connection = _db.GetConnection())
        {
            return await connection.ExecuteAsync(query, new { Id = id });
        }
    }
}
