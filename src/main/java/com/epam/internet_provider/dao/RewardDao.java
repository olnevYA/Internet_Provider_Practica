package com.epam.internet_provider.dao;

import com.epam.internet_provider.model.Reward;

import java.util.List;

public interface RewardDao {

  List<Reward> getRewards();

  boolean addReward(int reward_id, String login);
}
