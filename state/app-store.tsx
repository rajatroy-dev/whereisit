import { config } from '@/tamagui.config';
import { useEffect } from 'react';
import { useColorScheme } from 'react-native';
import { create, ExtractState } from 'zustand';
import { combine } from 'zustand/middleware';

const useAppStore = create(
    combine(
        { theme: config.themes.dark },
        (set) => ({
            setTheme: (value: 'light' | 'dark' | null | undefined) => set(() => ({
                theme: value === undefined || value === null || value === 'dark'
                    ? config.themes.light
                    : config.themes.dark
            })),
        })
    ),
);

const useAppTheme = () => {
    const colorScheme = useColorScheme();
    const theme = useAppStore((state) => state.theme);
    const setTheme = useAppStore((state) => state.setTheme);

    useEffect(() => setTheme(colorScheme), []);

    return theme;
}

type AppState = ExtractState<typeof useAppStore>;

export default useAppStore;
export { AppState, useAppTheme };
