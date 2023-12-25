import com.carrotsearch.junitbenchmarks.BenchmarkOptions;
import com.carrotsearch.junitbenchmarks.BenchmarkRule;
import com.epam.internet_provider.util.HashingUtil;
import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.MethodRule;

public class HashingPerformanceTest extends Assert {
  @Rule public MethodRule benchmarkRun = new BenchmarkRule();

  @BenchmarkOptions(benchmarkRounds = 100, warmupRounds = 10)
  @Test
  public void testHashing() {
    String pass = "Ария На Всегда";
    Assert.assertTrue(HashingUtil.checkString(pass, HashingUtil.hashString(pass)));
  }
}
