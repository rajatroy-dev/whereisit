import { create, ExtractState } from 'zustand';
import { combine } from 'zustand/middleware';

const useAppStore = create(
    combine(
        { theme: 'dark' },
        (set) => ({
            setTheme: (value: string) => set(() => ({ theme: value })),
        })
    ),
);

type AppState = ExtractState<typeof useAppStore>;

export default useAppStore;
export { AppState };
