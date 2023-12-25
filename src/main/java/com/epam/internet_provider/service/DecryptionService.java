package com.epam.internet_provider.service;

public interface DecryptionService {

  String decryptString(String encrypted);

  String getPublicKey();
}
