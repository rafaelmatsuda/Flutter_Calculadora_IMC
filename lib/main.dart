import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    setState(() {
      _infoText = "Infome seus dados";
    });
    weightController.text = "";
    heightController.text = "";
  }

  void calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      //Divide por 100 pois altura está em CM
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      print(imc);
      if (imc < 18.6) {
        _infoText = "Abaixo do Peso(${imc.toStringAsPrecision(4)})";
      }
      else if(imc>= 18.6 && imc < 24.9){
        _infoText = "Peso Ideal(${imc.toStringAsPrecision(4)})";
      }else if(imc>= 24.9 && imc < 29.9){
        _infoText = "Levemente Acima do Peso(${imc.toStringAsPrecision(4)})";
      }else if(imc>= 29.9 && imc < 34.9){
        _infoText = "Obesidade Grau I(${imc.toStringAsPrecision(4)})";
      }else if(imc>= 34.9 && imc < 39.9){
        _infoText = "Obesidade Grau II(${imc.toStringAsPrecision(4)})";
      }else if(imc>= 40){
        _infoText = "Obesidade Grau III(${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira o peso";
                  }
                  try{
                    double.parse(value);
                  }catch(e){
                    return "Peso inválido :(";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira a altura";
                  }
                  try{
                    double.parse(value);
                  }catch(e){
                    return "Altura inválida :(";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                "$_infoText",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
          )
        ));
  }
}
