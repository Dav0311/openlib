import 'package:flutter/material.dart';
import 'package:openlibrary/courseScreens/BusAdmin.dart';
import 'package:openlibrary/courseScreens/InfoTech.dart';
import 'MyBooksScreen.dart';
import 'courseScreens/ICTDiploma.dart';
import 'courseScreens/ComEngineer.dart';
import 'courseScreens/Electrical.dart';
import 'courseScreens/ComputerScience.dart';
import 'SettingsScreen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/src/material/icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigator(
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case '/MyBooksScreen':
              return MaterialPageRoute(builder: (_) => MyBooksScreen());
            case '/SettingsScreen':
              return MaterialPageRoute(builder: (_) => SettingsScreen());
            case '/ICTDiploma':
              return MaterialPageRoute(builder: (_) => ICTDiplomaScreen(pdfPath: 'assets/Apis.pdf',));
            case '/ComEngineer':
              return MaterialPageRoute(builder: (_) => ComEngineerScreen(pdfPath: 'assets/Com.pdf',));
            case '/Electrical':
              return MaterialPageRoute(builder: (_) => ElectricalScreen(pdfPath: 'assets/data.pdf',));
            case '/ComputerScience':
              return MaterialPageRoute(builder: (_) => ComputerScienceScreen(pdfPath: 'assets/SQL.pdf',));
            case '/InfoTech':
              return MaterialPageRoute(builder: (_) => InfoTechScreen(pdfPath: 'assets/C.pdf',));
            case '/BusAdmin':
              return MaterialPageRoute(builder: (_) => BusAdminScreen(pdfPath: 'assets/buz.pdf',));
            case '/PDFViewerScreen':
              final pdfPath = settings.arguments as String;
              return MaterialPageRoute(
                builder: (_) => PDFViewerScreen(pdfPath: pdfPath),
              );
            default:
              return null;
          }
        },
      ),
    );
  }

}

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  PDFViewerScreen({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
      ),
      body: SfPdfViewer.asset(pdfPath),
    );
  }
}


class HomeScreen extends StatelessWidget {
  final List<String> departmentNames = [
    'ICTechnology',
    'Com Engineering',
    'EE Engineering',
    'Computer Science',
    'Information Technology Business',
    'Business Administration (DBA)',
    'Records & Archives Management',
    'Accounting & Finance (DA)',
    'Procurement & Logistics Management',
    'NCIT',
    'NCCE',
    'NCEE',
    'NCBA',
    'Higher Education Certificate', // New department
    'Higher Education Certificate', // New department
  ];

  final List<IconData> departmentIcons = [
  Icons.settings_input_antenna_sharp, // Use valid icons like this
  Icons.waves,
  Icons.grid_3x3,
  Icons.computer_rounded,
  Icons.perm_device_information,
  Icons.business,
  Icons.book_sharp,
  Icons.money,
  Icons.airplanemode_active_sharp,
  Icons.business,
  Icons.school,
  Icons.computer,
  Icons.book_online_sharp,
  Icons.school,
  Icons.menu,
];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COURSES'),
        backgroundColor: Color.fromARGB(235, 3, 41, 67),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 columns
              ),
              itemBuilder: (context, index) {
                final name = departmentNames[index];
                final icon = departmentIcons[index];
                return _buildDepartmentTile(name, icon, context);
              },
              itemCount: departmentNames.length,
            ),
          ),
        ],
      ),


      // Add your bottom navigation bar here
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(236, 4, 8, 83),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Library',
            backgroundColor: Color.fromARGB(236, 4, 8, 83),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Color.fromARGB(236, 4, 8, 83),
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Navigate to My Books screen
            Navigator.of(context).pushNamed('/MyBooksScreen');
          } else if (index == 2) {
            // Navigate to Settings screen
            Navigator.of(context).pushNamed('/SettingsScreen');
          }
          // Handle other navigation here if needed
        },
      ),
    );
  }

  Widget _buildDepartmentTile(String name, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (name == 'ICTechnology') {
          // Navigate to the PDF viewer screen with the specified PDF file path
          Navigator.of(context).pushNamed(
            '/ICTDiplomaScreen',
            arguments: '/Users/ronaldjjingo/Desktop/Development/openlibraryf/openlibrary/assets/Apis.pdf',
          );
        } else {
          // Navigate to the corresponding department screen
          switch (name) {
            case 'Com Engineering':
              Navigator.of(context).pushNamed('/ComEngineerScreen');
              break;
            case 'EE Engineering':
              Navigator.of(context).pushNamed('/ElectricalScreen');
              break;
            case 'Computer Science':
              Navigator.of(context).pushNamed('/ComputerScienceScreen');
              break;
            case 'Information Technology Business':
              Navigator.of(context).pushNamed('/InfoTechScreen');
              break;
            case 'Business Administration (DBA)':
              Navigator.of(context).pushNamed('/BusAdminScreen');
              break;
            // Add cases for other departments here
          }
        }
      },
      child: Card(
        color: Color.fromARGB(244, 7, 43, 63),
        margin: EdgeInsets.all(8.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40.0,
                color: Color.fromARGB(255, 13, 1, 1),
              ),
              SizedBox(height: 5.0),
              Text(
                name,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

