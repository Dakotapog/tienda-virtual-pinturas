package com.tiendapinturas;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import java.util.List;
import java.util.Optional;

@SpringBootApplication
public class App {
    public static void main(String[] args) {
        SpringApplication.run(App.class, args);
    }
}

// Entidad para representar productos de pintura
@Entity
class Pintura {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String nombre;
    private String color;
    private String tipo; // látex, acrílica, esmalte, etc.
    private Double precio;
    private Integer stock;

    // Getters y setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    
    public Double getPrecio() { return precio; }
    public void setPrecio(Double precio) { this.precio = precio; }
    
    public Integer getStock() { return stock; }
    public void setStock(Integer stock) { this.stock = stock; }
}

// Repositorio para acceder a la base de datos
@Repository
interface PinturaRepository extends JpaRepository<Pintura, Long> {
    List<Pintura> findByColor(String color);
    List<Pintura> findByTipo(String tipo);
}

// Controlador REST para exponer endpoints
@RestController
@RequestMapping("/api/pinturas")
class PinturaController {
    
    @Autowired
    private PinturaRepository pinturaRepository;
    
    // Obtener todas las pinturas
    @GetMapping
    public List<Pintura> getAllPinturas() {
        return pinturaRepository.findAll();
    }
    
    // Obtener una pintura por ID
    @GetMapping("/{id}")
    public Pintura getPinturaById(@PathVariable Long id) {
        return pinturaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pintura no encontrada con id: " + id));
    }
    
    // Crear una nueva pintura
    @PostMapping
    public Pintura createPintura(@RequestBody Pintura pintura) {
        return pinturaRepository.save(pintura);
    }
    
    // Actualizar una pintura existente
    @PutMapping("/{id}")
    public Pintura updatePintura(@PathVariable Long id, @RequestBody Pintura pinturaDetails) {
        Pintura pintura = pinturaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pintura no encontrada con id: " + id));
        
        pintura.setNombre(pinturaDetails.getNombre());
        pintura.setColor(pinturaDetails.getColor());
        pintura.setTipo(pinturaDetails.getTipo());
        pintura.setPrecio(pinturaDetails.getPrecio());
        pintura.setStock(pinturaDetails.getStock());
        
        return pinturaRepository.save(pintura);
    }
    
    // Eliminar una pintura
    @DeleteMapping("/{id}")
    public void deletePintura(@PathVariable Long id) {
        pinturaRepository.deleteById(id);
    }
    
    // Endpoint para verificar que el servicio está funcionando
    @GetMapping("/status")
    public String status() {
        return "Servicio de Tienda de Pinturas activo y funcionando!";
    }
}