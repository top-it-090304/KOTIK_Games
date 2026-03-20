shader_type canvas_item;

// Параметры, которые можно менять в инспекторе
uniform vec4 base_color : source_color = vec4(0.8, 0.7, 0.6, 1.0); // Цвет металла (золотистый/латунь)
uniform float metallic_strength : hint_range(0.0, 1.0) = 0.9;      // Сила металлического отражения
uniform float roughness : hint_range(0.0, 1.0) = 0.3;              // Шероховатость (0 = зеркало, 1 = матовый)
uniform float edge_brightness = 0.8;                               // Яркость краев

void fragment() {
    // 1. Базовый цвет кнопки
    vec4 metal_color = base_color;
    
    // 2. Создаем градиент от краев к центру (эффект объема)
    vec2 uv = UV;
    // Расстояние от края (чем ближе к краю, тем значение ближе к 0)
    float dist_to_edge = min(uv.x, min(uv.y, min(1.0 - uv.x, 1.0 - uv.y)));
    // Инвертируем, чтобы края были ярче
    float edge_factor = pow(1.0 - dist_to_edge, 2.0) * edge_brightness;
    
    // 3. Добавляем шум для создания текстуры "зерна" металла
    float grain = texture(TEXTURE, UV * 50.0).r; // Используем текстуру шума или псевдо-шум
    // Простой псевдо-шум без текстуры:
    float simple_noise = fract(sin(UV.x * 500.0 + UV.y * 300.0) * 43758.5453);
    float metal_grain = (simple_noise - 0.5) * 0.15;
    
    // 4. Расчет металлического блика (имитация отражения света)
    // Свет падает сверху-слева
    vec2 light_dir = normalize(vec2(-0.5, -0.8));
    vec2 normal = vec2(0.0, 0.0); // Упрощенная нормаль для плоскости
    float lighting = max(0.2, dot(light_dir, vec2(0.0, 1.0))); // Базовая освещенность
    
    // 5. Финальный цвет: смешиваем цвет металла, яркость краев и освещение
    vec3 final_color = metal_color.rgb;
    final_color += vec3(edge_factor);          // Добавляем свечение к краям
    final_color += vec3(metal_grain);           // Добавляем зернистость
    final_color *= (lighting + metallic_strength * 0.5); // Умножаем на освещение
    
    // Делаем цвет более насыщенным в зависимости от металлической силы
    final_color = mix(final_color, final_color * vec3(1.2, 1.1, 0.9), metallic_strength);
    
    COLOR = vec4(final_color, metal_color.a);
    
    // 6. Эффект при наведении (будет добавлен позже через код)
    // Мы добавим изменение цвета в гейм-логику, а не в шейдер, чтобы было проще
}