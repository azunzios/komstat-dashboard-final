import * as React from 'react';
import ImageList from '@mui/material/ImageList';
import ImageListItem from '@mui/material/ImageListItem';

function srcset(image, size, rows = 1, cols = 1) {
    return {
        src: `${image}?w=${size * cols}&h=${size * rows}&fit=crop&auto=format`,
        srcSet: `${image}?w=${size * cols}&h=${size * rows
            }&fit=crop&auto=format&dpr=2 2x`,
    };
}

export default function QuiltedImageList() {
    return (
        <ImageList
            sx={{ width: '100%', height: 450 }}
            variant="quilted"
            cols={4}
            rowHeight={121}
        >
            {itemData.map((item) => (
                <ImageListItem key={item.img} cols={item.cols || 1} rows={item.rows || 1}>
                    <img
                        {...srcset(item.img, 121, item.rows, item.cols)}
                        alt={item.title}
                        loading="lazy"
                    />
                </ImageListItem>
            ))}
        </ImageList>
    );
}

const itemData = [
    {
        img: 'https://images.unsplash.com/photo-1517066309059-d12704e5501a?w=300&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGdhcyUyMGVtaXNzaW9uc3xlbnwwfHwwfHx8MA%3D%3D',
        title: 'Global GHGE',
        rows: 2,
        cols: 2,
    },
    {
        img: 'https://images.unsplash.com/photo-1612367197927-e08291bda33d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGdhcyUyMGVtaXNzaW9uc3xlbnwwfHwwfHx8MA%3D%3D',
        title: 'Global GHGE',
        rows: 3,
        cols: 2,
    },
    {
        img: "https://images.pexels.com/photos/14815440/pexels-photo-14815440.jpeg?auto=compress&cs=tinysrgb&w=600",
        title: "Asap dari Pembangkit Listrik",
        rows: 2,
        cols: 1,
    },
    {
        img: "https://images.pexels.com/photos/19735418/pexels-photo-19735418/free-photo-of-a-factory-chimney.jpeg?auto=compress&cs=tinysrgb&w=800",
        title: "Pembangkit Listrik Tenaga Uap",
        rows: 3,
        cols: 1,
    },
    {
        img: "https://images.pexels.com/photos/68482/embers-glow-wood-burn-68482.jpeg?auto=compress&cs=tinysrgb&w=600",
        title: "Polusi Industri Berat",
        rows: 1,
        cols: 2,
    },
    {
        img: "https://images.pexels.com/photos/6045858/pexels-photo-6045858.jpeg?auto=compress&cs=tinysrgb&w=800",
        title: "Lahan Pertanian dan Penggunaan Pupuk",
        rows: 1,
        cols: 2,
    },
    {
        img: "https://images.pexels.com/photos/9835979/pexels-photo-9835979.jpeg?auto=compress&cs=tinysrgb&w=300",
        title: "Kebakaran Hutan Liar"
    },
    {
        img: "https://images.pexels.com/photos/15269692/pexels-photo-15269692/free-photo-of-a-trash-file-of-trash.jpeg?auto=compress&cs=tinysrgb&w=600",
        title: "Tempat Pembuangan Sampah (Emisi Metana)",
        rows: 1,
        cols: 2,
    },
    {
        img: "https://images.pexels.com/photos/356036/pexels-photo-356036.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        title: "Pengeboran Minyak dan Gas Lepas Pantai"
    },
    {
        img: "https://images.pexels.com/photos/3634730/pexels-photo-3634730.jpeg?auto=compress&cs=tinysrgb&w=800",
        title: "Pesawat Terbang di Ketinggian (Emisi Aviasi)",
        rows: 1,
        cols: 2,
    },
    {
        img: "https://images.pexels.com/photos/682078/pexels-photo-682078.jpeg?auto=compress&cs=tinysrgb&w=800",
        title: "Deforestasi untuk Lahan",
        rows: 2,
        cols: 1,
    },
    {
        img: "https://images.pexels.com/photos/6754760/pexels-photo-6754760.jpeg?auto=compress&cs=tinysrgb&w=600",
        title: "Pembakaran Gas suar (Gas Flaring)",
        rows: 2,
        cols: 1,
    }   
];