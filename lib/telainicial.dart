import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: TelaInicial()));
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool homem = true;
  bool mulher = false;
  double altura = 165.0;
  int peso = 70;

  void _selecionarHomem() {
    setState(() {
      homem = true;
      mulher = false;
    });
  }

  void _selecionarMulher() {
    setState(() {
      homem = false;
      mulher = true;
    });
  }

  void _aumentarPeso() {
    setState(() {
      peso++;
    });
  }

  void _diminuirPeso() {
    setState(() {
      peso--;
    });
  }

  double calcularIMC(double altura, int peso) {
    double fatorSexo = homem ? 1.0 : 0.9;
    return peso / ((altura / 100) * (altura / 100)) * fatorSexo;
  }

  String interpretarIMC(double imc) {
    if (imc < 18.5) {
      return "Abaixo do Peso";
    } else if (imc >= 18.5 && imc < 24.9) {
      return "Peso Normal";
    } else if (imc >= 25 && imc < 29.9) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc < 34.9) {
      return "Obesidade Grau 1";
    } else if (imc >= 35 && imc < 39.9) {
      return "Obesidade Grau 2";
    } else {
      return "Obesidade Grau 3";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        backgroundColor: Colors.blue[700],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://img.freepik.com/vetores-premium/icone-de-balanca-de-peso-icone-de-balanca-de-equilibrio-estilo-de-vida-de-saude-icone-de-design-plano-ilustracao-vetorial_183665-356.jpg?w=2000',
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: homem ? null : _selecionarHomem,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0),
                    primary: homem ? Colors.blue[300] : Colors.blue,
                  ),
                  child: Text(
                    'Homem',
                  style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: mulher ? null : _selecionarMulher,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0),
                    primary: mulher ? Colors.pink[300] : Colors.pink,
                  ),
                  child: Text(
                    'Mulher',
                    style: TextStyle(color: Colors.black) ,),
                  
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Slider(
              value: altura,
              min: 100,
              max: 230,
              onChanged: (newValue) {
                setState(() {
                  altura = newValue.roundToDouble();
                });
              },
              activeColor: Colors.black,
            ),
            Text('Altura: ${altura.toInt()} cm',style: TextStyle(color: Colors.black)),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _diminuirPeso,
                  child: Text('-',style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 16.0),
                Text('Peso: $peso kg',style: TextStyle(color: Colors.black)),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _aumentarPeso,
                  child: Text('+',style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                double imc = calcularIMC(altura, peso);
                String interpretacao = interpretarIMC(imc);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Resultado do IMC",
                      style: TextStyle(color: Colors.black)),
                      content: Text(
                          "Seu IMC: ${imc.toStringAsFixed(2)}\nInterpretação: $interpretacao"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK",
                          style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Calcular',
              style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
