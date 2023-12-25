import com.epam.internet_provider.dao.TariffDao;
import com.epam.internet_provider.dao.impl.TariffDaoImpl;
import com.epam.internet_provider.model.Tariff;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class TariffDaoTest extends Assert {

  private Tariff tariff = new Tariff();
  private TariffDao tariffDao = new TariffDaoImpl();

  @Before
  public void initTariff() {
    tariff.setTitle("Test");
    tariff.setTraffic(100);
    tariff.setCost(10);
    tariff.setUploadSpeed(10);
    tariff.setDownloadSpeed(10);
    tariff.setImgUrl("/testImage.jpg");
    tariffDao.createTariff(tariff);
  }

  @Test
  public void checkTariff() {
    Tariff testTariff = tariffDao.getTariff(tariff.getTitle());
    Assert.assertEquals(testTariff.getTitle(), tariff.getTitle());
    Assert.assertEquals(testTariff.getCost(), tariff.getCost());
    Assert.assertEquals(testTariff.getDownloadSpeed(), tariff.getDownloadSpeed());
    Assert.assertEquals(testTariff.getImgUrl(), tariff.getImgUrl());
    Assert.assertEquals(testTariff.getTraffic(), tariff.getTraffic());
  }

  @After
  public void deleteTariff() {
    tariffDao.deleteTariff(tariff.getTitle());
  }
}
