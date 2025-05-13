import IconSymbol from '@/components/ui/IconSymbol';
import useAppStore from '@/state/app-store';
import { config } from '@/tamagui.config';
import { Tabs } from 'expo-router';
import React from 'react';
import { Platform } from 'react-native';

export default function TabLayout() {
  const currentTheme = useAppStore((state) => state.theme);
  const theme = currentTheme === 'dark' ? config.themes.dark : config.themes.light;

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: theme.accentColor.val,
        tabBarActiveBackgroundColor: theme.background.val,
        headerShown: false,
        tabBarStyle: Platform.select({
          ios: {
            // Use a transparent background on iOS to show the blur effect
            position: 'absolute',
          },
          default: {},
        }),
      }}>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Home',
          tabBarIcon: ({ color }) => <IconSymbol size={28} name="home" color={color} />,
        }}
      />
    </Tabs>
  );
}
