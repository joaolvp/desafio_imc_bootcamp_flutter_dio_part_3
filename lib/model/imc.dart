class DadosIMC{
  double _peso = 0.0 ;
  double _altura = 0.0;

  DadosIMC(double peso, double altura){
    _peso = peso;
    _altura = altura;
  

  }

  calcular(){
    double imc = _peso / (_altura * _altura);
    return imc;
  }

}