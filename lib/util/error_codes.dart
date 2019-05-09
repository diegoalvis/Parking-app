class ErrorCodes {
  final List<String> errorMsg = [
    "Usuario o contraseña erroneos",
    "La cedula o el celular ya se encuentran registrados",
    "No puedes agregar mas vehiculos",
    "Recurso no encontrado",
    "Zona no disponible",
    "Dinero no suficiente",
    "No hay tiempo disponible",
    "Las contraseñas no coinciden",
    "Debe tener al menos un vehiculo",
    "No es posible usar el GPS"
  ];

  validateError(int error){
      if(error != 0){
        throw AppException(cause:errorMsg[error - 1]);
      }
  }
}

class AppException implements Exception{
  String cause;
  AppException({this.cause});
}


String errorMessage(Exception e){
  String msg = e.toString();
  if(e is AppException){
    msg = e.cause;
  }
  return msg;
}