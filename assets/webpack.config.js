const path = require('path');
const webpack = require('webpack');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const AssetsPlugin = require('assets-webpack-plugin');
const MomentTimezoneDataPlugin = require('moment-timezone-data-webpack-plugin');
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;


module.exports = (env, argv) => {
    const isDevelopment = argv.mode !== 'production';

    result = {
        entry: [
            `./assets/js/base.js`,
            `./assets/js/webapp.js`
        ],
        resolve: {
            alias: {
                jquery: "jquery/src/jquery"
            }
        },
        mode: isDevelopment ? 'development' : argv.mode,
        output: {
            path: path.join(__dirname, '..', 'static', 'js'),
            chunkFilename: "[name].[contenthash].js",
            publicPath: '/static/js/',
            filename: 'webapp.[contenthash].js',
        },
        optimization: {
            minimize: !isDevelopment
        },
        performance: {
            hints: false
        },
        target: ['web', 'es5'],
        module: {
            rules: [
                {
                    test: /\.js$/,
                    exclude: /node_modules/,
                    use: [
                        {
                            loader: 'babel-loader'
                        }
                    ]

                },
                {
                    test: /\.module\.s(a|c)ss$/,
                    use: [
                        isDevelopment ? 'style-loader' : MiniCssExtractPlugin.loader,
                        {
                            loader: 'css-loader',
                            options: {
                                modules: true,
                                sourceMap: isDevelopment
                            }
                        },
                        {
                            loader: 'sass-loader',
                            options: {
                                sourceMap: isDevelopment
                            }
                        }
                    ]
                },
                {
                    test: /\.s(a|c)ss$/,
                    exclude: /\.module.(s(a|c)ss)$/,
                    use: [
                        isDevelopment ? 'style-loader' : MiniCssExtractPlugin.loader,
                        'css-loader',
                        {
                            loader: 'sass-loader',
                            options: {
                                sourceMap: isDevelopment
                            }
                        }
                    ]
                },
                {
                    test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
                    loader: 'file-loader',
                    options: {
                        outputPath: '../fonts',
                        publicPath: '/static/fonts'
                    },
                }
            ]
        },
        devtool: isDevelopment ? "eval-source-map" : "source-map",
        plugins: [
            new MomentTimezoneDataPlugin({
                matchZones: ["Europe/Berlin", 'Etc/UTC'],
                startYear: 2000,
                endYear: 2040,
            }),
            new MiniCssExtractPlugin({
                filename: '../css/webapp.[contenthash].css',
                chunkFilename: '[id].[hash].css'
            }),
            new CleanWebpackPlugin(),
            new AssetsPlugin({path: path.join(__dirname, '..', "static")})
        ]
    };

    if (isDevelopment) {
        result.plugins.push(
            new BundleAnalyzerPlugin({
                analyzerHost: '0.0.0.0'
            })
        );
    }
    return result;
};
