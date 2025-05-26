package com.example.shopapp.controllers;

import com.example.shopapp.dtos.CategoryDTO;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/categories")
public class CategoryController {
    @GetMapping("")
    public ResponseEntity<String> getAllCategories(
            @RequestParam("page") int page,
            @RequestParam("limit") int limit
    ) {
        return ResponseEntity.ok(String.format("Gia trị page = %d, gia tri limit = %d", page, limit));
    }

    @PostMapping("")
    public ResponseEntity<?> insertCategory(
            @Valid @RequestBody CategoryDTO categoryDTO,
            BindingResult result
    ) {
        if (result.hasErrors()) {
            List<String> errorMessges = result.getFieldErrors()
                    .stream()
                    .map(fieldError -> fieldError.getDefaultMessage())
                    .toList();
            return ResponseEntity.badRequest().body(errorMessges);
        }
        return ResponseEntity.ok("Inserted category successful" + categoryDTO.getName());
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> putCategory() {
        return ResponseEntity.ok("updated category");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteCategory() {
        return ResponseEntity.ok("Deleted category");
    }
}
