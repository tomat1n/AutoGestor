import '../entities/cliente.dart';

abstract class ClienteRepository {
  Future<List<Cliente>> getAllClientes();
  Future<Cliente?> getClienteById(int id);
  Future<Cliente> createCliente(Cliente cliente);
  Future<Cliente> updateCliente(Cliente cliente);
  Future<void> deleteCliente(int id);
  Future<List<Cliente>> searchClientes(String query);
  Future<int> getTotalClientes();
  Future<List<Cliente>> getClientesAtivos();
}