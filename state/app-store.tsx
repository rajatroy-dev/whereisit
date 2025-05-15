import { config } from '@/tamagui.config';
import { useEffect } from 'react';
import { useColorScheme } from 'react-native';
import { create, ExtractState } from 'zustand';
import { combine } from 'zustand/middleware';

const useAppStore = create(
    combine(
        {
            theme: config.themes.dark,
            colorScheme: 'dark'
        },
        (set) => ({
            setTheme: (value: 'light' | 'dark' | null | undefined) => set(() => ({
                theme: value === undefined || value === null || value === 'dark'
                    ? config.themes.dark
                    : config.themes.light
            })),
            setColorScheme: (value: 'light' | 'dark' | null | undefined) => set(() => ({
                colorScheme: value === undefined || value === null || value === 'dark'
                    ? 'dark'
                    : 'light'
            }))
        })
    ),
);

const useAppTheme = () => {
    const systemColorScheme = useColorScheme();

    const theme = useAppStore((state) => state.theme);
    const colorScheme = useAppStore((state) => state.colorScheme);
    const setTheme = useAppStore((state) => state.setTheme);
    const setColorScheme = useAppStore((state) => state.setColorScheme);

    useEffect(() => {
        if (colorScheme !== systemColorScheme) {
            setTheme(systemColorScheme);
            setColorScheme(systemColorScheme);
        }
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);

    return theme;
}

type AppState = ExtractState<typeof useAppStore>;

export default useAppStore;
export { AppState, useAppTheme };
