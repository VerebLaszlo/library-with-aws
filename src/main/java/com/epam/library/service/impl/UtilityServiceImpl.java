package com.epam.library.service.impl;

import com.epam.library.service.*;

import com.amazonaws.regions.*;

import org.springframework.stereotype.*;

import java.util.*;

@Service
public class UtilityServiceImpl implements UtilityService {
    private static final String DEFAULT_NAME = "localhost";

    @Override
    public String getRegion() {
        return Optional.ofNullable(Regions.getCurrentRegion())
                       .map(Region::getName)
                       .orElse(DEFAULT_NAME);
    }
}
