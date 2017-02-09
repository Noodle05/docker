package org.gaofamily.jasypt.cli;

import org.bouncycastle.jce.provider.BouncyCastleProvider;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.salt.RandomSaltGenerator;
import org.kohsuke.args4j.Argument;
import org.kohsuke.args4j.CmdLineException;
import org.kohsuke.args4j.CmdLineParser;
import org.kohsuke.args4j.Option;
import org.kohsuke.args4j.OptionHandlerFilter;
import org.kohsuke.args4j.spi.BooleanOptionHandler;

import java.security.Provider;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Wei Gao
 * @since 2/4/17
 */
public class EncryptionUtil {
    @Option(name = "-e", aliases = "--encrypt", handler = BooleanOptionHandler.class, forbids = {"-d"}, depends = {"-p"}, usage = "encrypt")
    private boolean encrypt = false;

    @Option(name = "-d", aliases = "--decrypt", handler = BooleanOptionHandler.class, forbids = {"-e"}, depends = {"-p"}, usage = "decrypt")
    private boolean decrypt = false;

    @Option(name = "-l", aliases = "--list-algorithm", handler = BooleanOptionHandler.class, forbids = {"-e", "-d", "-p"}, usage = "list all algorithm")
    private boolean list = false;

    @Option(name = "-v", aliases = "--verbose", handler = BooleanOptionHandler.class, usage = "verbose")
    private boolean verbose = false;

    @Option(name = "-a", aliases = "--algorithm", usage = "Algorithm", metaVar = "Algorithm")
    private String algorithm = "PBEWITHSHA256AND256BITAES-CBC-BC";

    @Option(name = "-p", aliases = "--password", usage = "Encryption password", metaVar = "password")
    private String password;

    @Option(name = "-k", aliases = "--key-obtention-iterations", usage = "Key Obtention Iterations")
    private int keyObtentionIterations = 1000;

    @Option(name = "-q", aliases = "--quiet", handler = BooleanOptionHandler.class, usage = "Quiet mode")
    private boolean quiet;

    @Argument(multiValued = true, metaVar = "encrypt/decrypt values")
    private List<String> vals = new ArrayList<>();

    public void doMain(String[] args) {
        CmdLineParser parser = new CmdLineParser(this);

        try {
            parser.parseArgument(args);
        } catch (CmdLineException e) {
            System.err.println(e.getMessage());
            System.err.println("Usage");
            parser.printUsage(System.err);
            System.err.println();
            System.err.println("Example: " + parser.printExample(OptionHandlerFilter.ALL));
            return;
        }

        Provider provider = new BouncyCastleProvider();
        if (list) {
            provider.getServices().forEach(service -> System.out.println("Algorithm: " + service.getAlgorithm()));
        } else if (encrypt || decrypt) {
            final StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
            encryptor.setProvider(provider);
            encryptor.setAlgorithm(algorithm);
            encryptor.setPassword(password);
            encryptor.setKeyObtentionIterations(keyObtentionIterations);
            encryptor.setSaltGenerator(new RandomSaltGenerator());
            vals.forEach(val -> printResult(val, decrypt ? encryptor.decrypt(val) : encryptor.encrypt(val)));
        } else {
            System.err.println("Usage");
            parser.printUsage(System.err);
            System.err.println();
            System.err.println("Example: " + parser.printExample(OptionHandlerFilter.ALL));
        }
    }

    private void printResult(String orig, String result) {
        if (!quiet) {
            System.out.print(orig + " => ");
        }
        System.out.println(result);
    }

    public static void main(String[] args) {
        EncryptionUtil util = new EncryptionUtil();
        util.doMain(args);
    }
}

