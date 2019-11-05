class Vendedor {
	var property certificaciones = []
	
	method agregarCertificado(pts, haySobreDeProducto) {
		certificaciones.add(new Certificacion(puntos = pts, esSobreDeProducto = haySobreDeProducto))
	}
	method sacarCertificado(certificado) {
		certificaciones.remove(certificado)
	}
	
	method puedeTrabajarEnCiudad(ciudad) 
	
	
	method esVersatil() 
	
	method esFirme() {
		return certificaciones.sum({certificado => certificado.puntos()}) >= 30
	}
	
	method esInfluyente()
}

class VendedorFijo inherits Vendedor{
	var property ciudadQueVive
	
	override method puedeTrabajarEnCiudad(ciudad) {
		return ciudad == self.ciudadQueVive()
	}
	override method esVersatil() {
		return certificaciones.size() >= 3
	}
	override method esInfluyente() {
		return false
	}
}

class Viajante inherits Vendedor {
	var property provinciasQuePuedeTrabajar = []
	
	override method puedeTrabajarEnCiudad(ciudad) {
		return provinciasQuePuedeTrabajar.any({provincia => provincia == ciudad.provincia() })
	}
	override method esVersatil() {
		return certificaciones.any({certificado => certificado.esSobreProductos()}) >= 1
	}
	override method esInfluyente() {
		return provinciasQuePuedeTrabajar.sum({provincia => provincia.poblacion()}) >= 10000000
	}
}

class ComercioCorresponsal inherits Vendedor {
	var property ciudadesQueTieneSucursal = []
	override method puedeTrabajarEnCiudad(ciudad) {
		return ciudadesQueTieneSucursal.any({city => city == ciudad})
	}
	override method esVersatil() {
		return certificaciones.any({certificado => (not certificado.esSobreProductos() )})
	}
	override method esInfluyente() {
		var tieneAlMenos5Sucursales = ciudadesQueTieneSucursal.size() >= 5
		var tieneAlMenos3Provincias = ciudadesQueTieneSucursal.size({city => city.provincia()}) >= 3
		return tieneAlMenos5Sucursales or tieneAlMenos3Provincias
	}
}

class Certificacion {
	var property puntos
	var property esSobreDeProducto
}

class Ciudad {
	var property provincia = #{}
	
}
class Provincia {
	var property poblacion
}