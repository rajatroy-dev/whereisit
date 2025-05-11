import { themes } from '@/themes';
import { defaultConfig } from '@tamagui/config/v4';
import { createTamagui } from '@tamagui/core';

export const config = createTamagui({
    ...defaultConfig,
    themes,
})
