enum Error {
    ImageError(image::ImageError),
    IoError(std::io::Error),
}

impl From<image::ImageError> for Error {
    fn from(error: image::ImageError) -> Self {
        Error::ImageError(error)
    }
}

impl From<std::io::Error> for Error {
    fn from(error: std::io::Error) -> Self {
        Error::IoError(error)
    }
}

impl rustler::Encoder for Error {
    fn encode<'a>(&self, env: rustler::env::Env<'a>) -> rustler::Term<'a> {
        let msg = match &self {
            Error::ImageError(error) => match error {
                image::ImageError::Decoding(_) => "Decoding error",
                image::ImageError::Encoding(_) => "Encoding error",
                image::ImageError::Parameter(_) => "Parameter error",
                image::ImageError::Limits(_) => "Limits error",
                image::ImageError::Unsupported(_) => "Unsupported format error",
                image::ImageError::IoError(_) => "Image IO error",
            },
            Error::IoError(_) => "Error reading the buffer",
        };

        let mut msg_binary = rustler::NewBinary::new(env, msg.len());
        msg_binary.as_mut_slice().clone_from_slice(msg.as_bytes());

        msg_binary.into()
    }
}

#[rustler::nif]
fn crop_and_grayscale<'a>(
    env: rustler::env::Env<'a>,
    image_buffer: rustler::types::Binary<'a>,
    x: u32,
    y: u32,
    width: u32,
    height: u32,
) -> std::result::Result<rustler::types::Binary<'a>, Error> {
    let reader =
        image::io::Reader::new(std::io::Cursor::new(&*image_buffer)).with_guessed_format()?;

    let mut image = reader.decode()?;

    image = image.grayscale().crop(x, y, width, height);

    let mut out = rustler::types::NewBinary::new(env, image.as_bytes().len());

    image.write_to(
        &mut std::io::BufWriter::new(std::io::Cursor::new(out.as_mut_slice())),
        image::ImageOutputFormat::Png,
    )?;

    Ok(out.into())
}

rustler::init!("Elixir.SnippingCrab.SnippyCrab", [crop_and_grayscale]);
