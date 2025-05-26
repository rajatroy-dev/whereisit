import { config } from '@/tamagui.config';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { useEffect } from 'react';
import { useColorScheme } from 'react-native';
import { create, ExtractState } from 'zustand';
import { combine } from 'zustand/middleware';

const useAppStore = create(
    combine(
        {
            theme: config.themes.dark,
        },
        (set) => ({
            setTheme: (value: string | null | undefined) => set(() => {
                AsyncStorage.setItem('theme', value || 'dark');
                return {
                    theme: value === undefined || value === null || value === 'dark'
                        ? config.themes.dark
                        : config.themes.light
                };
            }),
        })
    ),
);

const useAppTheme = () => {
    const systemColorScheme = useColorScheme();

    const theme = useAppStore((state) => state.theme);
    const setTheme = useAppStore((state) => state.setTheme);

    useEffect(() => {
        AsyncStorage.getItem('theme')
            .then((value) => {
                if (value) {
                    setTheme(value);
                } else if (systemColorScheme) {
                    AsyncStorage.setItem('theme', systemColorScheme)
                        .then(() => {
                            setTheme(systemColorScheme);
                        });
                }
            });
        // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);

    return theme;
}

type AppState = ExtractState<typeof useAppStore>;

export default useAppStore;
export { AppState, useAppTheme };
