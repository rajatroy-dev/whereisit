import IconSymbol from '@/components/ui/IconSymbol';
import { useAppTheme } from '@/state/app-store';
import { useMemo } from 'react';
import {
  GestureResponderEvent,
  StyleSheet,
  Text,
  TouchableOpacity,
  View
} from 'react-native';

export default function ImagePickerWrapper({
  label,
  onCamera,
  onGallery
}: IImagePickerWrapper) {
  const theme = useAppTheme();

  const styles = useMemo(() => stylesheet(
    theme.color.val
  ), [theme]);

  return (
    <View style={[styles.addAnImageQuestion, { marginBottom: 16 }]}>
      <Text style={styles.text}>{label}</Text>
      <View style={styles.imageSelection}>
        <TouchableOpacity style={styles.cameraSelection} onPress={onCamera}>
          <IconSymbol name='camera' color={theme.accentColor.val} size={32} />
        </TouchableOpacity>
        <TouchableOpacity style={styles.gallerySelection} onPress={onGallery}>
          <IconSymbol name='image' color={theme.accentColor.val} size={32} />
        </TouchableOpacity>
      </View>
    </View>
  );
}

const stylesheet = (color?: string) => StyleSheet.create({
  text: {
    color: color,
    paddingHorizontal: 10,
    textAlign: 'center'
  },
  addAnImageQuestion: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center'
  },
  imageSelection: {
    flexDirection: 'row'
  },
  cameraSelection: {
    paddingRight: 10
  },
  gallerySelection: {
    paddingLeft: 10,
    paddingRight: 5
  }
});

type IImagePickerWrapper = {
  label: string;
  onCamera: ((event: GestureResponderEvent) => void) | undefined;
  onGallery: ((event: GestureResponderEvent) => void) | undefined;
};