class Cliente {
  int index;
  String urlImagen;
  String nombre;
  String apellido;
  String profesion;
  DateTime fechaNacimiento;

  Cliente(this.nombre, this.apellido, this.profesion, this.fechaNacimiento,
      {this.index,this.urlImagen});
}
