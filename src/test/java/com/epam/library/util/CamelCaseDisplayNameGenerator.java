package com.epam.library.util;

import org.junit.jupiter.api.*;

import java.lang.reflect.*;
import java.util.stream.*;

public class CamelCaseDisplayNameGenerator extends DisplayNameGenerator.ReplaceUnderscores {
    @Override
    public String generateDisplayNameForClass(Class<?> testClass) {
        return prependUppercaseWithSpace(super.generateDisplayNameForClass(testClass));
    }

    @Override
    public String generateDisplayNameForMethod(Class<?> testClass, Method testMethod) {
        return prependUppercaseWithSpace(super.generateDisplayNameForMethod(testClass, testMethod));
    }

    private static String prependUppercaseWithSpace(String classDisplayName) {
        return IntStream.range(0, classDisplayName.length())
                        .mapToObj(i -> prependUppercaseWithSpace(classDisplayName, i))
                        .collect(Collectors.joining());
    }

    private static String prependUppercaseWithSpace(String classDisplayName, int charIndex) {
        return getPrefix(classDisplayName, charIndex) + classDisplayName.charAt(charIndex);
    }

    private static String getPrefix(CharSequence classDisplayName, int charIndex) {
        return shouldPrepend(classDisplayName, charIndex) ? " " : "";
    }

    private static boolean shouldPrepend(CharSequence classDisplayName, int charIndex) {
        return (isPreviousCharacterLowerCase(classDisplayName, charIndex)
                || isNextCharacterLowerCase(classDisplayName, charIndex))
               && Character.isUpperCase(classDisplayName.charAt(charIndex));
    }

    private static boolean isPreviousCharacterLowerCase(CharSequence classDisplayName, int charIndex) {
        return isNotFirstCharacter(charIndex) && Character.isLowerCase(classDisplayName.charAt(charIndex - 1));
    }

    private static boolean isNextCharacterLowerCase(CharSequence classDisplayName, int charIndex) {
        return isNotLastCharacter(classDisplayName, charIndex)
               && Character.isLowerCase(classDisplayName.charAt(charIndex + 1));
    }

    private static boolean isNotFirstCharacter(int charIndex) {
        return charIndex > 0;
    }

    private static boolean isNotLastCharacter(CharSequence classDisplayName, int charIndex) {
        return charIndex < classDisplayName.length() - 1;
    }
}
