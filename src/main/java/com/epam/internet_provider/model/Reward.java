package com.epam.internet_provider.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
/**
 * Class Reward that has properties: {@link Reward#rewardId}, {@link Reward#title}, {@link
 * Reward#bonusPoints} and {@link Reward#imgHref}.
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reward {

  @Column(name = "reward_id")
  private int rewardId;

  @Column(name = "title")
  private String title;

  @Column(name = "bonus_points")
  private int bonusPoints;

  @Column(name = "img_href")
  private String imgHref;
}
