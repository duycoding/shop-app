package com.example.shopapp.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;

public class OrderDTO {
    @JsonProperty("user_id")
    @Min(value = 1, message = "User's id must be > 0")
    private Long userId;

    @JsonProperty("fullname")
    private String fullName;

    private String email;

    @JsonProperty("phone_number")
    @NotBlank(message = "Phone Number is required")
    private String phoneNumber;

    private String address;

    private String note;

    @JsonProperty("total_money")
    private Float totalMoney;

    @JsonProperty("shipping_method")
    private Float shippingMethod;

    @JsonProperty("shipping_address")
    private Float shippingAddress;

    @JsonProperty("payment_method")
    private Float paymentMethod;


}
