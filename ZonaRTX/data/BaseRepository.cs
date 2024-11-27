using Dapper;
using ZonaRTX.data;

public class BaseRepository<T> : IBaseRepository<T>
{
    private readonly ISqlDataAccess _db;
    private static readonly Dictionary<string, string> TableMap = new Dictionary<string, string>
    {
        { "CategoriasModel", "Categorias" },
        { "InventarioModel", "Inventario" },
        // Agregar más modelos a tablas aquí según sea necesario
    };

    public BaseRepository(ISqlDataAccess db)
    {
        _db = db;
    }

    private string GetTableName()
    {
        var modelName = typeof(T).Name;
        return TableMap.ContainsKey(modelName) ? TableMap[modelName] : $"{modelName}s";  // Usar plural por defecto
    }

    public async Task<IEnumerable<T>> GetAllAsync()
    {
        var tableName = GetTableName();
        var query = $"SELECT * FROM {tableName}";
        using (var connection = _db.GetConnection())
        {
            return await connection.QueryAsync<T>(query);
        }
    }

    public async Task<T> GetByIdAsync(int id)
    {
        var tableName = GetTableName();
        var query = $"SELECT * FROM {tableName} WHERE id = @Id";
        using (var connection = _db.GetConnection())
        {
            return await connection.QueryFirstOrDefaultAsync<T>(query, new { Id = id });
        }
    }

    public async Task<int> InsertAsync(T entity)
    {
        var tableName = GetTableName();
        var query = $"INSERT INTO {tableName} (/* columnas aquí */) VALUES (/* valores aquí */)";
        using (var connection = _db.GetConnection())
        {
            return await connection.ExecuteAsync(query, entity);
        }
    }

    public async Task<int> UpdateAsync(T entity)
    {
        var tableName = GetTableName();
        var query = $"UPDATE {tableName} SET /* columnas = valores */ WHERE id = @Id";
        using (var connection = _db.GetConnection())
        {
            return await connection.ExecuteAsync(query, entity);
        }
    }

    public async Task<int> DeleteAsync(int id)
    {
        var tableName = GetTableName();
        var query = $"DELETE FROM {tableName} WHERE id = @Id";
        using (var connection = _db.GetConnection())
        {
            return await connection.ExecuteAsync(query, new { Id = id });
        }
    }
}
