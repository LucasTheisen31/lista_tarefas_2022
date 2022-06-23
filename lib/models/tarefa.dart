class Tarefa {

  //construutores
  Tarefa({required this.titulo, required this.data});

  Tarefa.fromjson(Map<String, dynamic> json) : titulo = json['titulo'], data = DateTime.parse(json['data']);//Um Nomeclasse.fromJson()construtor, para construir uma nova Userinstância a partir de uma estrutura de mapa.
  //ou seja Tarefa.fromjson vai instanciar um objeto tipo Tarefa a partir de um mapa

  //atributos
  String titulo;
  DateTime data;

  //metodos

  //metodo para transformar converter o objeto em Json para poder armazenalo posteriormente
  //em formato Json so podemos armazenar tipos primitivos (String, int, bool etc), entao o DateTime tem que ser cnvertido para String
  //toIso8601String() é um padrao de armazenamento de data e horario
  //motodo toJson da classe é chamado automaticamente pelo metodo jsonEncode()
  //Um toJson()método, que converte uma Userinstância em um mapa.
  Map<String, dynamic> toJson() {
    return{
      'titulo': titulo,
      'data': data.toIso8601String()
    };



  }
}
