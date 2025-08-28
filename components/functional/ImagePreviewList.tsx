import { IImageData } from '@/app/(tabs)/add/index';
import { Image } from 'expo-image';
import { FlatList, View } from 'react-native';

export default function ImagePreviewList({ data }: { data: IImageData[] }) {
  return (
    <View
      style={{
        justifyContent: 'center',
        alignItems: 'center',
        height: 216
      }}>
      <FlatList
        horizontal
        data={data}
        renderItem={({ item, index }) => (
          <Image
            style={{
              borderRadius: 5,
              height: 200,
              width: 200,
              marginLeft: 10,
              marginRight: index === data.length - 1 ? 10 : 0
            }}
            source={{ uri: item.imagePath }} />
        )} />
    </View>
  );
}