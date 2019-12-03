class DataClient {
  
  int id;
  String name;
  String lastName;
  String address;
  String email;
  String birthdate;
  int phone;
  String token;

  DataClient({
    this.id,
    this.name,
    this.lastName,
    this.address,
    this.email,
    this.birthdate,
    this.phone,
    this.token
  });

  //Para insertar los datos en la base de datos, se necesita convertir en un Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'address': address,
      'email': email,
      'birthdate': birthdate,
      'phone': phone,
      'token': token
    };
  }

  //Para leer datos:
  //Se necesita convertir de un Map a un JSON.
  factory DataClient.fromMap(Map<String, dynamic> json) => new DataClient(
    id : json['id'],
    name : json['name'],
    lastName : json['lastName'],
    address : json['address'],
    email : json['email'],
    birthdate : json['birthdate'],
    phone : json['phone'],
    token : json['token']
  );
  
}