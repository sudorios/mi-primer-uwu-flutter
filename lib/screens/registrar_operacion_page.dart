import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_state.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';
import 'package:flutteroperacionrest/screens/operacion_list_page.dart';

class RegistrarOperacionPage extends StatelessWidget{
  
  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController descripcionCtrl = TextEditingController();
  final TextEditingController cantidadCtrl = TextEditingController();
  final TextEditingController montoCtrl = TextEditingController();
  final TextEditingController responsableCtrl = TextEditingController();
  @override
  Widget build(BuildContext context){
  return BlocProvider(
    create: (_) => OperacionBloc(OperacionRepository()),
    child: Scaffold(
      appBar: AppBar(title: Text('Registrar Operacion')),
      body: Container(
        padding: EdgeInsets.all(20),
        child: BlocConsumer<OperacionBloc, OperacionState>(
          listener: (context, state){
            if(state is OperacionSuccess){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Operacion registrada exitosamente'))
              );
              idCtrl.clear();
              descripcionCtrl.clear();
              cantidadCtrl.clear();
              montoCtrl.clear();
              responsableCtrl.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const OperacionListPage()));
              }else if(state is OperacionFailure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}'))
              );
              } 
          },
          builder: (context, state){
            return SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: idCtrl,
                    decoration: InputDecoration(labelText: 'ID Operacion'),
                  ),
                  TextField(
                    controller: descripcionCtrl,
                    decoration: InputDecoration(labelText: 'Descripcion'),
                  ),
                  TextField(
                    controller: cantidadCtrl,
                    decoration: InputDecoration(labelText: 'Cantidad'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: montoCtrl,
                    decoration: InputDecoration(labelText: 'Monto'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: responsableCtrl,
                    decoration: InputDecoration(labelText: 'Responsable'),
                  ),
                  SizedBox(height: 20),
                  if(state is OperacionLoading)
                  CircularProgressIndicator()
                  else 
                  ElevatedButton(onPressed: (){
                    context.read<OperacionBloc>().add(
                      RegistrarOperacion(
                      idOperacion: idCtrl.text,
                      descripcion: descripcionCtrl.text, 
                      cantidad: int.tryParse(cantidadCtrl.text) ?? 0,
                      monto: double.tryParse(montoCtrl.text)!.toInt(),
                      responsable: responsableCtrl.text,)
                    );
                  }, child: Text("Guardar"),)
                ]
              )
            );
          }
        ),
      ),
    ));
  }  
}