package com.epam.internet_provider.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
/**
 * Class Tariff that has properties: {@link Tariff#id}, {@link Tariff#title}, {@link Tariff#cost},
 * {@link Tariff#downloadSpeed}, {@link Tariff#uploadSpeed}, {@link Tariff#traffic} and {@link Tariff#imgUrl}.
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Tariff {

  @Column(name = "tariff_id")
  private int id;

  @Column(name = "title")
  private String title;

  @Column(name = "cost")
  private int cost;

  @Column(name = "download_speed")
  private int downloadSpeed;

  @Column(name = "upload_speed")
  private int uploadSpeed;

  @Column(name = "traffic")
  private int traffic;

  @Column(name = "img_url")
  private String imgUrl;
}
