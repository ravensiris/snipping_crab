#[rustler::nif]
fn crop_and_grayscale<'a>(
    env: rustler::env::Env<'a>,
    image_buffer: rustler::types::Binary<'a>,
    x: u32,
    y: u32,
    width: u32,
    height: u32,
) -> rustler::types::Binary<'a> {
    let reader = image::io::Reader::new(std::io::Cursor::new(&*image_buffer))
        .with_guessed_format()
        .unwrap();

    let mut image = reader.decode().unwrap();

    image = image.grayscale().crop(x, y, width, height);

    let mut out = rustler::types::NewBinary::new(env, image.as_bytes().len());

    image
        .write_to(
            &mut std::io::BufWriter::new(std::io::Cursor::new(out.as_mut_slice())),
            image::ImageOutputFormat::Png,
        )
        .unwrap();

    out.into()
}

rustler::init!("Elixir.SnippingCrab.SnippyCrab", [crop_and_grayscale]);
