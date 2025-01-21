class RandomUser {
  String gender;
  Name name;
  Location location;
  String email;
  Login login;
  Dob dob;
  Registered registered;
  String phone;
  String cell;
  Id id;
  Picture picture;
  String nat;

  RandomUser({
    required this.gender,
    required this.name,
    required this.location,
    required this.email,
    required this.login,
    required this.dob,
    required this.registered,
    required this.phone,
    required this.cell,
    required this.id,
    required this.picture,
    required this.nat,
  });

  // Factory constructor to parse JSON
  factory RandomUser.fromJson(Map<String, dynamic> json) {
    return RandomUser(
      gender: json['gender'],
      name: Name.fromJson(json['name']),
      location: Location.fromJson(json['location']),
      email: json['email'],
      login: Login.fromJson(json['login']),
      dob: Dob.fromJson(json['dob']),
      registered: Registered.fromJson(json['registered']),
      phone: json['phone'],
      cell: json['cell'],
      id: Id.fromJson(json['id']),
      picture: Picture.fromJson(json['picture']),
      nat: json['nat'],
    );
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({required this.title, required this.first, required this.last});

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class Location {
  Street street;
  String city;
  String state;
  String country;
  String postcode;

  Location({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      street: Street.fromJson(json['street']),
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'].toString(),
    );
  }
}

class Street {
  int number;
  String name;

  Street({required this.number, required this.name});

  factory Street.fromJson(Map<String, dynamic> json) {
    return Street(
      number: json['number'],
      name: json['name'],
    );
  }
}

class Login {
  String uuid;
  String username;

  Login({required this.uuid, required this.username});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      uuid: json['uuid'],
      username: json['username'],
    );
  }
}

class Dob {
  String date;
  int age;

  Dob({required this.date, required this.age});

  factory Dob.fromJson(Map<String, dynamic> json) {
    return Dob(
      date: json['date'],
      age: json['age'],
    );
  }
}

class Registered {
  String date;
  int age;

  Registered({required this.date, required this.age});

  factory Registered.fromJson(Map<String, dynamic> json) {
    return Registered(
      date: json['date'],
      age: json['age'],
    );
  }
}

class Id {
  String name;
  String value;

  Id({required this.name, required this.value});

  factory Id.fromJson(Map<String, dynamic> json) {
    return Id(
      name: json['name'],
      value: json['value'] ?? '',
    );
  }
}

class Picture {
  String large;
  String medium;
  String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}
