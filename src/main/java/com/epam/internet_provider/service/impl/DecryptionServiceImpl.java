package com.epam.internet_provider.service.impl;

import com.epam.internet_provider.service.DecryptionService;
import io.vavr.control.Try;

import javax.crypto.Cipher;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

public class DecryptionServiceImpl implements DecryptionService {

  private static final int KEY_SIZE = 1024;

  private static class LazyKeysHolder {
    static final KeyPair KEY_PAIR = generateKeys();
  }

  private static KeyPair generateKeys() {
    KeyPairGenerator keyPairGenerator = Try.of(() -> KeyPairGenerator.getInstance("RSA")).get();
    keyPairGenerator.initialize(KEY_SIZE);
    return keyPairGenerator.genKeyPair();
  }

  @Override
  public String decryptString(String encrypted) {
    return Try.of(
            () -> {
              Cipher cipher = Cipher.getInstance("RSA");
              cipher.init(Cipher.DECRYPT_MODE, LazyKeysHolder.KEY_PAIR.getPrivate());
              return new String(cipher.doFinal(Base64.getDecoder().decode(encrypted)));
            })
        .getOrNull();
  }

  @Override
  public String getPublicKey() {
    return Try.of(
            () ->
                Base64.getEncoder()
                    .encodeToString(
                        KeyFactory.getInstance("RSA")
                            .getKeySpec(
                                LazyKeysHolder.KEY_PAIR.getPublic(), X509EncodedKeySpec.class)
                            .getEncoded()))
        .get();
  }
}
