import 'package:flutter/material.dart';

void main() {
  runApp(const SipWebsiteApp());
}

class SipWebsiteApp extends StatelessWidget {
  const SipWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoSIP - Construcción Sustentable',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Verde oscuro ecológico
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  
  // Claves para la navegación con scroll
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _benefitsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 800;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = _isDesktop(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black26,
        title: Row(
          children: [
            Icon(Icons.eco, color: Theme.of(context).colorScheme.primary, size: 32),
            const SizedBox(width: 8),
            const Text(
              'EcoSIP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: isDesktop
            ? [
                _NavBarItem(title: 'Inicio', onTap: () => _scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut)),
                _NavBarItem(title: '¿Qué es SIP?', onTap: () => _scrollTo(_aboutKey)),
                _NavBarItem(title: 'Beneficios', onTap: () => _scrollTo(_benefitsKey)),
                _NavBarItem(title: 'Proyectos', onTap: () => _scrollTo(_projectsKey)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _scrollTo(_contactKey),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cotizar'),
                  ),
                ),
              ]
            : [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black87),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ],
      ),
      endDrawer: isDesktop
          ? null
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.eco, color: Colors.white, size: 48),
                        SizedBox(height: 8),
                        Text('EcoSIP', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ListTile(title: const Text('Inicio'), onTap: () { Navigator.pop(context); _scrollController.animateTo(0, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut); }),
                  ListTile(title: const Text('¿Qué es SIP?'), onTap: () { Navigator.pop(context); _scrollTo(_aboutKey); }),
                  ListTile(title: const Text('Beneficios'), onTap: () { Navigator.pop(context); _scrollTo(_benefitsKey); }),
                  ListTile(title: const Text('Proyectos'), onTap: () { Navigator.pop(context); _scrollTo(_projectsKey); }),
                  ListTile(title: const Text('Contacto'), onTap: () { Navigator.pop(context); _scrollTo(_contactKey); }),
                ],
              ),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(context, isDesktop),
            _buildAboutSection(context, isDesktop),
            _buildBenefitsSection(context, isDesktop),
            _buildProjectsSection(context, isDesktop),
            _buildContactSection(context, isDesktop),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isDesktop) {
    return Container(
      height: isDesktop ? 600 : 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        image: DecorationImage(
          image: const NetworkImage('https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?q=80&w=2000&auto=format&fit=crop'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Construcción Sustentable\ndel Futuro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isDesktop ? 56 : 36,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Edificios y hogares ecológicos, rápidos de construir y altamente eficientes con Paneles SIP.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: isDesktop ? 20 : 16,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => _scrollTo(_contactKey),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('COTIZAR MI PROYECTO'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, bool isDesktop) {
    return Container(
      key: _aboutKey,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24, vertical: 80),
      color: Colors.white,
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://images.unsplash.com/photo-1503387762-592deb58ef4e?q=80&w=1000&auto=format&fit=crop',
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: isDesktop ? 60 : 0, height: isDesktop ? 0 : 40),
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Qué son los Paneles SIP?',
                  style: TextStyle(
                    fontSize: isDesktop ? 36 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Los Paneles Estructurales Aislados (SIP por sus siglas en inglés) son un sistema de construcción avanzado que ofrece un aislamiento térmico superior y una resistencia estructural excepcional.\n\nEstán compuestos por un núcleo de espuma aislante rígida intercalado entre dos revestimientos estructurales, generalmente tableros de virutas orientadas (OSB).',
                  style: TextStyle(fontSize: 16, color: Colors.black54, height: 1.6),
                ),
                const SizedBox(height: 24),
                OutlinedButton.icon(
                  onPressed: () => _scrollTo(_benefitsKey),
                  icon: const Icon(Icons.arrow_downward),
                  label: const Text('Conoce los beneficios'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection(BuildContext context, bool isDesktop) {
    return Container(
      key: _benefitsKey,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24, vertical: 80),
      color: Colors.grey[50],
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Beneficios del Sistema SIP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Construcción inteligente para un futuro sostenible',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _BenefitCard(
                icon: Icons.thermostat,
                title: 'Aislación Térmica',
                description: 'Ahorro de hasta un 60% en costos de calefacción y refrigeración gracias a su núcleo aislante continuo.',
                width: isDesktop ? 300 : double.infinity,
              ),
              _BenefitCard(
                icon: Icons.timer,
                title: 'Rapidez de Montaje',
                description: 'Reduce los tiempos de construcción hasta en un 50% comparado con métodos tradicionales.',
                width: isDesktop ? 300 : double.infinity,
              ),
              _BenefitCard(
                icon: Icons.eco,
                title: 'Sustentabilidad',
                description: 'Menor generación de residuos en obra y uso eficiente de materiales ecológicos y reciclables.',
                width: isDesktop ? 300 : double.infinity,
              ),
              _BenefitCard(
                icon: Icons.shield,
                title: 'Alta Resistencia',
                description: 'Estructura sismorresistente y de gran durabilidad, superando estándares de construcción convencionales.',
                width: isDesktop ? 300 : double.infinity,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context, bool isDesktop) {
    final List<String> projectImages = [
      'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?q=80&w=800&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=800&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?q=80&w=800&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?q=80&w=800&auto=format&fit=crop',
    ];

    return Container(
      key: _projectsKey,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24, vertical: 80),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Nuestros Proyectos',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Inspiración en construcción sustentable',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 60),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 16 / 9,
            ),
            itemCount: projectImages.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      projectImages[index],
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        'Proyecto Residencial ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, bool isDesktop) {
    return Container(
      key: _contactKey,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 24, vertical: 80),
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      width: double.infinity,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Comienza tu Proyecto',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isDesktop ? 32 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Déjanos tus datos y un experto en construcción SIP te contactará a la brevedad.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),
              const TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Cuéntanos sobre tu proyecto',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mensaje enviado correctamente. ¡Gracias!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('ENVIAR MENSAJE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      color: Colors.grey[900],
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.eco, color: Theme.of(context).colorScheme.primary, size: 32),
              const SizedBox(width: 8),
              const Text(
                'EcoSIP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Construyendo un futuro más verde y eficiente.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 40),
          const Divider(color: Colors.white24),
          const SizedBox(height: 20),
          const Text(
            '© 2024 EcoSIP Construcciones. Todos los derechos reservados.',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final double width;

  const _BenefitCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
