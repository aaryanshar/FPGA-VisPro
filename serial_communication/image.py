from PIL import Image
import numpy as np

def hex_to_rgb(hex_string):
    int_values = [int(hex_string[i:i+2], 16) for i in range(0, len(hex_string), 2)]
    return np.array(int_values, dtype=np.uint8)

def find_dimensions(total_pixels):
    factors = []
    for i in range(1, int(total_pixels**0.5)+1):
        if total_pixels % i == 0:
            factors.append((i, total_pixels // i))
    return factors

def closest_aspect_ratio(dimensions):
    target_ratio = 4/3  
    closest_dims = min(dimensions, key=lambda dim: abs(dim[0]/dim[1] - target_ratio))
    return closest_dims

def main():
    with open('/home/root/Desktop/pic_img.hex', 'r') as file:
        hex_data = file.read().replace('\n', '')

    rgb_values = hex_to_rgb(hex_data)
    total_pixels = len(rgb_values) // 3

    possible_dimensions = find_dimensions(total_pixels)
    print("Possible Dimensions:"),
    print(possible_dimensions)

   
    height, width = closest_aspect_ratio(possible_dimensions)
    
    try:
        image_data = rgb_values[:height * width * 3].reshape((height, width, 3))
        img = Image.fromarray(image_data)
        img.save('img_image.bmp')
        print("Image saved with dimensions: {}x{}".format(width, height))
    except Exception as e:
        print("Could not save image with dimensions: {}x{} - Error: {}".format(width, height, str(e)))

if __name__ == '__main__':
    main()




