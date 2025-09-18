import 'package:get_it/get_it.dart';
import '../../features/estoque/data/repositories/produto_repository.dart';
import '../../features/pdv/domain/services/pdf_service.dart';
import '../../features/pdv/domain/services/csv_service.dart';
import '../../features/configuracoes/data/repositories/empresa_config_repository.dart';
import '../../features/clientes/data/repositories/cliente_repository_impl.dart';
import '../../features/clientes/domain/repositories/cliente_repository.dart';
import '../../features/servicos/data/repositories/servicos_repository_impl.dart';
import '../../features/servicos/domain/repositories/servicos_repository.dart';
import '../../features/orcamentos/data/repositories/orcamentos_repository_impl.dart';
import '../../features/orcamentos/domain/repositories/orcamentos_repository.dart';
import '../../features/orcamentos/domain/services/orcamentos_service.dart';
import '../../features/orcamentos/presentation/providers/orcamentos_provider.dart';
import '../../features/ordens_servico/data/repositories/ordens_servico_repository_impl.dart';
import '../../features/ordens_servico/domain/repositories/ordens_servico_repository.dart';
import '../../features/ordens_servico/domain/services/ordens_servico_service.dart';
import '../../features/ordens_servico/presentation/providers/ordens_servico_provider.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/verificar_assinatura_usecase.dart';
import '../../features/auth/domain/usecases/criar_periodo_teste_usecase.dart';
import '../../features/auth/domain/services/admin_service.dart';
// import '../../features/whatsapp/domain/services/whatsapp_manager_service.dart';
// import '../../features/whatsapp/domain/services/whatsapp_sales_service.dart';
// import '../../features/whatsapp/domain/services/whatsapp_service.dart';
// import '../../features/whatsapp/domain/services/whatsapp_service_impl.dart';
// import '../../features/whatsapp/domain/repositories/whatsapp_repository.dart';
// import '../../features/whatsapp/data/repositories/whatsapp_repository.dart';
// import '../../features/whatsapp/presentation/providers/whatsapp_sales_provider.dart';
import '../database/database.dart';
import '../database/database_web.dart' if (dart.library.io) '../database/database_native.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // Database
  getIt.registerLazySingleton<AppDatabase>(() => constructDb());
  
  // Auth Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AppDatabase>()),
  );
  
  // Auth Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerLazySingleton<VerificarAssinaturaUseCase>(
    () => VerificarAssinaturaUseCase(getIt<AuthRepository>()),
  );
  
  getIt.registerLazySingleton<CriarPeriodoTesteUseCase>(
    () => CriarPeriodoTesteUseCase(getIt<AuthRepository>()),
  );
  
  // Admin Service
  getIt.registerLazySingleton<AdminService>(
    () => AdminService(getIt<AuthRepository>()),
  );
  
  // Auth Provider
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(
      getIt<AuthRepository>(),
      getIt<LoginUseCase>(),
      getIt<VerificarAssinaturaUseCase>(),
      getIt<CriarPeriodoTesteUseCase>(),
      getIt<AdminService>(),
    ),
  );
  
  // Other Repositories
  getIt.registerLazySingleton<ProdutoRepository>(
    () => ProdutoRepository(getIt<AppDatabase>()),
  );
  
  getIt.registerLazySingleton<EmpresaConfigRepository>(
    () => EmpresaConfigRepository(getIt<AppDatabase>()),
  );
  
  getIt.registerLazySingleton<ClienteRepository>(
    () => ClienteRepositoryImpl(getIt<AppDatabase>()),
  );
  
  getIt.registerLazySingleton<ServicosRepository>(
    () => ServicosRepositoryImpl(getIt<AppDatabase>()),
  );
  
  getIt.registerLazySingleton<OrcamentosRepository>(
    () => OrcamentosRepositoryImpl(getIt<AppDatabase>()),
  );
  
  getIt.registerLazySingleton<OrcamentosService>(
    () => OrcamentosService(getIt<OrcamentosRepository>()),
  );
  
  getIt.registerLazySingleton<OrcamentosProvider>(
    () => OrcamentosProvider(getIt<OrcamentosService>()),
  );

  getIt.registerLazySingleton<OrdensServicoRepository>(
    () => OrdensServicoRepositoryImpl(getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<OrdensServicoService>(
    () => OrdensServicoService(getIt<OrdensServicoRepository>()),
  );

  getIt.registerLazySingleton<OrdensServicoProvider>(
    () => OrdensServicoProvider(getIt<OrdensServicoService>()),
  );
  
  // Services
  getIt.registerLazySingleton<PdfService>(
    () => PdfService(getIt<EmpresaConfigRepository>()),
  );
  
  getIt.registerLazySingleton<CsvService>(
    () => CsvService(),
  );
  
  // WhatsApp Services - Temporariamente comentado devido a erros de compilação
  /*
  getIt.registerLazySingleton<WhatsAppRepository>(
    () => WhatsAppRepositoryImpl(),
  );
  
  getIt.registerLazySingleton<WhatsAppService>(
    () => WhatsAppServiceImpl(),
  );
  
  getIt.registerLazySingleton<WhatsAppManagerService>(
    () => WhatsAppManagerService(
      getIt<WhatsAppRepository>(),
      getIt<WhatsAppService>(),
    ),
  );
  
  getIt.registerLazySingleton<WhatsAppSalesService>(
    () => WhatsAppSalesService(
      whatsAppService: getIt<WhatsAppManagerService>(),
      pdfService: getIt<PdfService>(),
    ),
  );
  
  // WhatsApp Providers
  getIt.registerLazySingleton<WhatsAppSalesProvider>(
    () => WhatsAppSalesProvider(
      salesService: getIt<WhatsAppSalesService>(),
    ),
  );
  */
  
  print('Service locator configurado completamente');
}